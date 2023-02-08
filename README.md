# MyAccount1 - Setup Authentication

## Setup git access
```
https://github.com/nhson2022/MyAccount1.git

git remote add origin git@github.com:nhson2022/MyAccount1.git
git status
git add -A
git commit -m "Comment"
git push -u origin main
```
...
## Setup project
```hash
./bin/importmap pin jquery bootstrap
bundle add bootstrap
```

**Setup devise**

Goto page and follow instructions https://github.com/heartcombo/devise
```hash
bundle add devise
rails generate devise:install
rails g devise:views

rails generate devise User
rails db:migrate
```

**Update config/environments/development.rb**
```rb
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```
**Update app/views/layouts/application.html.erb**
```html
<div class="container">
  <% if notice.present? %>
    <div class="alert alert-primary mt-4" role="alert">
      <%= notice %>
    </div>
  <% end %>

  <% if alert.present? %>
    <div class="alert alert-danger mt-4" role="alert">
      <%= alert %>
    </div>
  <% end %>

  <%= yield %>
</div>
```
If your devise model is something other than User, replace "_user" with "_yourmodel". The same logic applies to the instructions below.

To verify if a user is signed in, use the following helper:
```rb
user_signed_in?
```
For the current signed-in user, this helper is available:
```rb
current_user
```
You can access the session for this scope:
```rb
user_session
```
You can also override after_sign_in_path_for and after_sign_out_path_for to customize your redirect hooks.

Notice that if your Devise model is called Member instead of User, for example, then the helpers available are:
```rb
before_action :authenticate_member!

member_signed_in?

current_member

member_session
```

## Devise - Update notice response

Create TurboController
```rb
# app/controllers/turbo_controller.rb
class TurboController < ApplicationController
  class Responder < ActionController::Responder
    def to_turbo_stream
      controller.render(options.merge(formats: :html))
    rescue ActionView::MissingTemplate => error
      if get?
        raise error
      elsif has_errors? && default_action
        render rendering_options.merge(formats: :html, status: :unprocessable_entity)
      else
        redirect_to navigation_location
      end
    end
  end

  self.responder = Responder
  respond_to :html, :turbo_stream
end
```

Update devise configuration
```rb
# config/initializers/devise.rb
# frozen_string_literal: true

class TurboFailureApp < Devise::FailureApp
  def respond
    if request_format == :turbo_stream
      redirect
    else
      super
    end
  end

  def skip_format?
    %w(html turbo_stream */*).include? request_format.to_s
  end
end

Devise.setup do |config|

  # ==> Controller configuration
  # Configure the parent class to the devise controllers.
  config.parent_controller = 'TurboController'

  # ==> Warden configuration
  config.warden do |manager|
    manager.failure_app = TurboFailureApp
  end

  config.navigational_formats = ['*/*', :html, :turbo_stream]
end
```

**Create controller pages home and info**
```hash
rails g controller pages home info
```

## [Admin] Create Article
Setup action text, active storage 
https://guides.rubyonrails.org/active_storage_overview.html 
https://guides.rubyonrails.org/action_text_overview.html

**Setup Active Storage**
```hash
bin/rails active_storage:install
bin/rails db:migrate
```
**Setup Action Text**
```hash
bin/rails action_text:install
bin/rails db:migrate
```
**Setup model, pages**
```hash
rails g scaffold Article title active:boolean
```

## Clone source
```
cd
clone https://github.com/nhson2022/MyAccount1.git
cd MyAccount1
bundle install
rails db:migrate
rails s
```