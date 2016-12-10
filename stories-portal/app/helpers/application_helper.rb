module ApplicationHelper
  def random_images
    images = ['bg4-notinclude.jpg', 'bg8-notinclude.jpg', 'bg9-notinclude.jpg', 'bg17-notinclude.jpg', 'bg24-notinclude.jpg', 'bg19-notinclude.jpg', 'bg26-notinclude.jpg', 'bg31-notinclude.jpg', 'bg33-notinclude.jpg']
    images[rand(images.size)]
  end

  # def month
  #   [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  # end
  # def year
  #   [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27]
  # end
end
