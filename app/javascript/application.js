// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import 'jquery'
import "channels"

$(document).on('turbo:load', function() {
    console.log('turbo:load')
    // Your code here
    }
)

$('body').on('click', function() {
    console.log('delete')
    // Your code here
}
)
