# rails formbuilder with datetimepicker

## Setting

Add these lines to your Gemfile:
```ruby
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.7.14'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'font-awesome-rails'
```

And then execute:
```bash
$ bundle install
```

Add the following to your JavaScript manifest file (`application.js`):
```js
//= require moment
//= require bootstrap-datetimepicker
```

Add the following to your style sheet file(`application.css.scss`):
```scss
// import bootstrap-sprockets before bootstrap if using bootstrap >= 3.2
@import "bootstrap-sprockets";
@import 'bootstrap';
@import 'bootstrap-datetimepicker';
```

Create `config/initializers/form.rb`:
```ruby
class CustomFormBuilder < ActionView::Helpers::FormBuilder

  def date_select(method, options = {}, html_options = {})
    if options[:picker]
      existing_date = @object.send(method)
      formatted_date = existing_date.to_date.strftime("%F") if existing_date.present?
      @template.content_tag(:div, :class => "input-group") do
        text_field(method, :value => formatted_date, :class => "form-control datepicker", :"data-date-format" => "YYYY-MM-DD") +
        @template.content_tag(:span, @template.content_tag(:span, "", :class => "fa fa-calendar") ,:class => "input-group-addon")
      end
    else
      super
    end
  end

  def datetime_select(method, options = {}, html_options = {})
    if options[:picker]
      existing_time = @object.send(method)
      formatted_time = existing_time.to_time.strftime("%F %I:%M %p") if existing_time.present?
      @template.content_tag(:div, :class => "input-group") do
        text_field(method, :value => formatted_time, :class => "form-control datetimepicker", :"data-date-format" => "YYYY-MM-DD hh:mm A") +
        @template.content_tag(:span, @template.content_tag(:span, "", :class => "fa fa-calendar") ,:class => "input-group-addon")
      end
    else
      super
    end
  end

end

# Set CustomBuilder as default FormBuilder
ActionView::Base.default_form_builder = CustomFormBuilder
```

Then restart the Rails server.

## Usage

In View call the `picker: true` and call datetimepicker(the jQuery methods)

```ruby
<%= form_for(@post) do |f| %>
  ...
	<%= f.datetime_select :published_at, picker: true %>
    <%= f.date_select :published_date, picker: true %>
  ...

<script type="text/javascript">
  $(function(){
    $('.datetimepicker').datetimepicker();
    $('.datepicker').datetimepicker();
  })
</script>
```


Thanks for https://github.com/TrevorS/bootstrap3-datetimepicker-rails
