Voom::Presenters.define(:event_actions) do
  attach :top_nav
  attach :events_drawer

  grid do
      column 1
      column 11 do
        heading 'Events'

        subheading 'Dialog'
        button 'dialog' do
          event :click do
            dialog :my_dialog
          end
        end
        attach :show_dialog

        subheading 'Replaces'
        button 'replaces' do
          event :click do
            replaces :replace_me, :replace_text, text: "I was replaced"
          end
        end
        attach :replace_text

        subheading 'Toggle Visibility'
        button 'toggle visiblity' do
          event :click do
            toggle_visiblity :toggle_me
          end
        end
        heading 'Sometimes I appear', id: :toggle_me

        subheading 'Snackbar'
        button 'snackbar' do
          event :click do
            snackbar 'I want a snack!'
          end
        end

        subheading context['reloaded'] ? "Reloaded" : 'Loads'
        button 'loads' do
          event :click do
            loads :events, reloaded: true
          end
        end
        heading context['reloaded'] ? "Reloaded" : 'Loaded'

        title "A Note on errors:"
        body ['These will display an error. Errors are displayed in four locations.',
              '1. Field/input level errors will display on the field/input.',
              '2. By default all content blocks will display errors. Use `show_errors=false` to turn this off on a block',
              '3. At the top of all forms.',
              '4. At the top of the page'], level: 2

        subheading 'Update'
        body 'issues a PUT to the passed path'
        content do
          button 'updates' do
            event :click do
              updates 'updatepath', {optional: :params}
            end
          end
        end

        subheading 'Delete'
        body 'issues a DELETE to the passed path'
        content do
          button 'deletes' do
            event :click do
              deletes 'deletepath', {optional: :params}
            end
          end
          subheading 'Posts'
          body "issues a POST to the passed path\nAlias: creates"
          content shows_errors: false do
            button 'posts' do
              event :click do
                posts 'postpath', {optional: :params}
              end
            end
          end
        end
      end
    end
  end