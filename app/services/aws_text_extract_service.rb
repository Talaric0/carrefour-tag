require 'aws-sdk'
require 'open-uri'

class AwsTextExtractService
  def initialize
    client = Aws::Textract::Client.new(region: 'eu-west-2')
    
    @resp = client.analyze_document({ document: { bytes: URI.open('CRLV3.png').read }, feature_types: ["FORMS"] })

    kv_hash = get_kv_hash

    kvs = get_kv_relationship(kv_hash[0], kv_hash[1], kv_hash[2])

    print_kvs(kvs)
  end

  def get_kv_hash
    key_hash = {}
    value_hash = {}
    block_hash = {}
    @resp.blocks.each do |block|
      block_id = block.id
      block_hash[block_id] = block
      if block.block_type == "KEY_VALUE_SET"
        if block.entity_types.include?("KEY")
          key_hash[block_id] = block
        else
          value_hash[block_id] = block
        end
      end
    end
    return key_hash, value_hash, block_hash
  end

  def get_kv_relationship(key_hash, value_hash, block_hash)
    kvs = {}
    key_hash.to_a.each do |_block_id, key_block|
      value_block = find_value_block(key_block, value_hash)
      key = get_text(key_block, block_hash)
      val = get_text(value_block, block_hash)
      kvs[key] = val
    end
    return kvs
  end

  def find_value_block(key_block, value_hash)
    value_block = ""
    key_block['relationships'].each do |relationship|
      next unless relationship['type'] == 'VALUE'

      relationship['ids'].each do |value_id|
        value_block = value_hash[value_id]
      end
    end
    return value_block
  end

  def get_text(result, blocks_hash)
    text = ''
    if result.relationships
      result['relationships'].each do |relationship|
        next unless relationship['type'] == 'CHILD'

        relationship['ids'].each do |child_id|
          word = blocks_hash[child_id]
          text += "#{word['text']} " if word['block_type'] == 'WORD'
          next unless word['block_type'] == 'SELECTION_ELEMENT'

          text += 'X ' if word['selection_status'] == 'SELECTED'
        end
      end
    end
    return text
  end

  def print_kvs(kvs)
    kvs.to_a.each do |key, value|
      "#{key}: #{value}"
    end
  end
end
