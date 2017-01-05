class Slide < ActiveRecord::Base
  def self.create_preview(params)
    return false if params[:title].nil? && params[:subtitle].nil? && params[:custom_background] == '0'
    slide = Slide.create(
      role: 'pending',
      ribbon: params[:ribbon],
      ribbon_color: params[:ribbon_color],
      title: params[:title],
      subtitle: params[:subtitle],
      ribbon_display: (params[:ribbon_display] == '0' ? false : true),
      active: (params[:active] == '0' ? false : true),
      display_rate: params[:display_rate],
      custom_background: params[:custom_background] || 'https://static1.squarespace.com/static/5602b79ee4b0a65d125ea3c4/t/57b37b0bb3db2b80ee031840/1471380241780/DSC05223.jpeg',
      custom: true
    )
  end

  def self.update_slides
    slides = fetch_slides
    delete_slides
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
