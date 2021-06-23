class PagesController < ApplicationController
  def home
  end

  def cartao
    @week_day = %w[DOM SEG TER QUAR QUI SEX SAB]
    @orders = current_user.orders
    @tags = current_user.tags
    @orders_hash = {}
    @orders.order('created_at DESC').each do |order|
      if @orders_hash[order.tag.nickname]
        if @orders_hash[order.tag.nickname]["#{@week_day[order.created_at.strftime('%w').to_i]}., #{order.created_at.strftime('%d/%m')}"]
          @orders_hash[order.tag.nickname]["#{@week_day[order.created_at.strftime('%w').to_i]}., #{order.created_at.strftime('%d/%m')}"] << order
        else
          @orders_hash[order.tag.nickname].merge!({ "#{@week_day[order.created_at.strftime('%w').to_i]}., #{order.created_at.strftime('%d/%m')}" => [order] })
        end
      else
        @orders_hash[order.tag.nickname] = { "#{@week_day[order.created_at.strftime('%w').to_i]}., #{order.created_at.strftime('%d/%m')}" => [order] }
      end  
    end
    @tag_total_amount = tag_total_amount
    @card_total = 670 + @tag_total_amount
  end

  def tag_info
  end

  def tag
    @tags = Tag.where(user: current_user)
    if @tags.empty?
      redirect_to tag_info_path
    else
      redirect_to tags_path
    end
  end

  private

  def tag_total_amount
    orders = current_user.orders
    sum = 0
    if orders
      orders.each do |order|
        sum += order.value   
      end
    end
    sum
  end
end
