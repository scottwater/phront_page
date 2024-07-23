return unless Rails.env.local?

module Kernel
  # Make your output stand out more in the Rails server console
  def buts(obj)
    black_background_white_text = "\e[30;47m"
    reset = "\e[0m"
    puts "#{black_background_white_text}#{obj.pretty_inspect}#{reset}"
  end
end
