require 'will_paginate/view_helpers/action_view'

module WillPaginate
  module ActionView
    def will_paginate(collection = nil, options = {})
      options, collection = collection, nil if collection.is_a? Hash
      collection ||= infer_collection_from_controller
      options[:renderer] ||= MobileLinkRenderer
      options[:previous_label] ||= '← 前へ'
      options[:next_label]     ||= '次へ →'
      super.try :html_safe
    end

    class MobileLinkRenderer < LinkRenderer
      protected

      def html_container(html)
        tag :nav, tag(:ul, html, class: 'pagination'), 'aria-label' => 'ページ移動'
      end

      def page_number(page)
        css = page == current_page ? 'page-item active' : 'page-item'
        tag :li, link(page, page, rel: rel_value(page), class: 'page-link'), class: css
      end

      def gap
        tag :li, tag(:span, '…', class: 'page-link'), class: 'page-item disabled'
      end

      def previous_or_next_page(page, text, classname)
        css = ['page-item', ('disabled' unless page)].compact.join(' ')
        tag :li, link(text, page || '#', class: 'page-link'), class: css
      end
    end
  end
end
