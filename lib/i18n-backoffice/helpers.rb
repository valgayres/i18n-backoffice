module I18n
  module Backoffice
    module Helpers
      def translation_input(key, initial_translation, custom_translation)
        <<-ROW
          <tr>
            <td>#{key}</td>
            <td>#{initial_translation}</td>
            <td><input name=translations[#{key}] value="#{custom_translation}"></td>
          </tr>
        ROW
      end

      def root_path
        "#{env['SCRIPT_NAME']}/"
      end
    end
  end
end