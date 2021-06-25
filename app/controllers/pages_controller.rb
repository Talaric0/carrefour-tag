class PagesController < ApplicationController
  def home
    @tag_total = tag_total_amount
    @card_amount = 730.50
    @discounts = 60.50
    @card_total = @card_amount + @tag_total - @discounts
    @limit = 4000
    @available = @limit - @card_total
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
    @card_total = 730.50 - 60.50 + @tag_total_amount
    @minimum_payment = @card_total * 0.15
  end

  def perfil
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
