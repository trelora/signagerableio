class Slide < ActiveRecord::Base
  def self.update_slides
    delete_slides
    slides = fetch_slides
    insert_slides(slides)
  end

  private
    def self.delete_slides
      Slide.delete_all
    end

    def self.fetch_slides
      roles = fetch_roles
      roles.map do |role|
        TreloraServices.new.house_listing(role)
      end.flatten
    end

    def self.fetch_roles
      TreloraServices.new.get_roles
    end

    def self.translate_roles
      roles = fetch_roles

      roles.reduce({}) do |translations, role|
        key = TreloraServices.new.house_listing(role.to_sym).first[:role]
        translations[key] = role
        translations
      end
    end

    def self.insert_slides(slides)
      translation = translate_roles
      slides.each do |slide|
        Slide.create(role: slide[:role],
                     api_role: translation[slide[:role]],
                     ribbon: slide[:ribbon],
                     ribbon_color: slide[:ribbon_color],
                     title: slide[:title],
                     subtitle: slide[:subtitle],
                     best_large_image: slide[:best_large_image]
        )
      end
    end
end
