class Slide < ActiveRecord::Base
  def self.display_custom_on_rotation(counter)
    custom_slides = Slide.where('custom = ? AND active = ?', true, true)
    if custom_slides.pluck(:display_rate).include?(counter)
      return custom_slides.where('display_rate = ?', counter).order('RANDOM()').first
    end
  end

  def update_preview?
    self.role =~ /[0-9]/
  end

  def preview_id
    self.role.split('-').last
  end

  def confirm_save
    if update_preview?
      slide_to_be_updated = Slide.find_by(id: preview_id)
      Slide.update_slide({orig: slide_to_be_updated, changes: self})
    elsif self.role.include?('pending')
      self.role = "confirm#{determine_role}"
      self.save
    end
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

  def self.create_preview(params, update_id = nil)
    return false if params[:title].empty? && params[:subtitle].empty? && params[:custom_background].empty?
    slide = Slide.create(
      role: (update_id ? "pending#{determine_role(params)}-#{update_id}" : "pending#{determine_role(params)}"),
      ribbon: params[:ribbon],
      ribbon_color: params[:ribbon_color],
      title: params[:title],
      subtitle: params[:subtitle],
      ribbon_display: (params[:ribbon_display] == '0' ? false : true),
      active: (params[:active] == '0' ? false : true),
      display_rate: params[:display_rate],
      custom_background: (params[:custom_background].empty? ? 'https://static1.squarespace.com/static/5602b79ee4b0a65d125ea3c4/t/57b37b0bb3db2b80ee031840/1471380241780/DSC05223.jpeg' : params[:custom_background]),
      custom: true
    )
  end

  def self.get_original_slide(id)
    slide = self.find(id)
    slide.update_preview? ? Slide.find(slide.preview_id) : slide
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
    def self.determine_role(params)
      if !params[:title].empty? && params[:subtitle].empty?
        '-lg-text'
      elsif !params[:title].empty? && !params[:subtitle].empty?
        '-lg-sub-text'
      elsif params[:title].empty? && !params[:subtitle].empty?
        '-sub-text'
      else
        '-custom-image'
      end
    end

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

    def self.update_slide(slides)
      slides[:orig].update(
        ribbon: slides[:changes].ribbon,
        ribbon_color: slides[:changes].ribbon_color,
        role: "confirm#{determine_role(slides[:changes])}",
        title: slides[:changes].title,
        subtitle: slides[:changes].subtitle,
        ribbon_display: slides[:changes].ribbon_display,
        active: slides[:changes].active,
        display_rate: slides[:changes].display_rate,
        custom_background: slides[:changes].custom_background,
      )
    end
end
