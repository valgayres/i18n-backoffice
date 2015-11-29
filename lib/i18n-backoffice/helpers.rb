module I18n
  module Backoffice
    module Helpers
      def translation_input(key, initial_translation, custom_translation)
        <<-ROW
          <tr>
            <td>#{key}</td>
            <td>#{initial_translation}</td>
            <td><input name=translations[#{key}]>#{custom_translation}</td>
          </tr>
        ROW
      end
    end
  end
end