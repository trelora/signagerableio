class Slide < ActiveRecord::Base
  def self.display_custom_on_rotation(counter)
    custom_slides = Slide.where('custom = ? AND active = ?', true, true)
    if custom_slides.pluck(:display_rate).include?(counter)
      return custom_slides.where('display_rate = ?', counter).order('RANDOM()').first
    end
  end

  def update_information(params)
    params[:display_rate] = params[:display_rate].to_i
    self.update(params)
    self.update(role: "confirm#{determine_role}")
  end

  def confirm_save
    self.role = "confirm#{determine_role}"
    self.custom = true
    self.display_rate = self.display_rate.to_i
    self.save
  end

  def determine_role
    if !title.empty? && subtitle.empty?
      '-lg-text'
    elsif !title.empty? && !subtitle.empty?
      '-lg-sub-text'
    elsif title.empty? && !subtitle.empty?
      '-sub-text'
    else
      '-custom-image'
    end
  end

  def custom_background?
    self.custom_background != 'https://static1.squarespace.com/static/5602b79ee4b0a65d125ea3c4/t/57b37b0bb3db2b80ee031840/1471380241780/DSC05223.jpeg'
  end

  def self.update_slides
    slides = fetch_slides
    delete_slides
    insert_slides(slides)
  end

  def custom_style
    role.split('-')[1..3].join(' ').capitalize
  end

  def self.update_counter(counter)
    return 1 if counter >= Slide.where('custom = ? AND active = ?', true, true).pluck(:display_rate).sort.last.to_i
    counter += 1
  end

  private
    def self.delete_slides
      slides = Slide.where.not(custom: true)
      slides.destroy_all
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
      slides.each do |slide|
        Slide.create(role: slide[:signage_role],
                     api_role: slide[:signage_role],
                     ribbon: slide[:signage_ribbon],
                     ribbon_color: slide[:signage_ribbon_color],
                     title: slide[:signage_title],
                     subtitle: slide[:signage_subtitle],
                     best_large_image: slide[:best_large_image]
        )
      end
    end
end
