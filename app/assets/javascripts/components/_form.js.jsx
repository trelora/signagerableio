var Form = React.createClass({
  saveSlide () {
    slide = this.props.slide
    if (slide.id) {
      $.ajax({
        url: `/api/v1/slides/${slide.id}`,
        type: 'PUT',
        data: {slide: slide},
        success: (data) => {
          this.props.handleSlideSaving(data)
        }
      })
    } else {
      $.ajax({
        url: '/api/v1/slides',
        type: 'POST',
        data: {slide: slide},
        success: (data) => {
          this.props.handleSlideSaving(data)
        }
      })
    }
  },

  discardChanges () {
    this.props.forgetIt()
  },

  titleChange (event) {
    this.props.handleTitleChange(event.target.value)
  },

  subtitleChange (event) {
    this.props.handleSubtitleChange(event.target.value)
  },

  ribbonTextChange (event) {
    this.props.handleRibbonTextChange(event.target.value)
  },

  ribbonColorChange (event) {
    this.props.handleRibbonColorChange(event.target.value)
  },

  customBgChange (event) {
    this.props.handleBgChange(event.target.value)
  },

  displayRateChange (event) {
    this.props.handleDisplayRateChange(event.target.value)
  },

  updateRibbonDisplay () {
    var display = !this.props.slide.ribbon_display
    this.props.updateRibbonDisplay(display)
  },

  updateActive () {
    var active = !this.props.slide.active
    this.props.updateActive(active)
  },

  render () {
    var defaultCustomBg = 'https://static1.squarespace.com/static/5602b79ee4b0a65d125ea3c4/t/57b37b0bb3db2b80ee031840/1471380241780/DSC05223.jpeg'
    return (
      <div>
        <label className='font-format'>Title</label>
        <input className='form-control' type='text' ref='title' id='slide_title' value={this.props.slide.title}
          onChange={this.titleChange} />
        <label className='font-format'>Subtitle</label>
        <textarea className='form-control' type='text' ref='subtitle' id='slide_subtitle' value={this.props.slide.subtitle}
          onChange={this.subtitleChange} />
        <label className='font-format'>Ribbon?</label>
        <input className='form-check' type='checkbox' checked={this.props.slide.ribbon_display ? 'checked' : ''} ref='ribbon_display' id='slide_ribbon_display'
          onClick={this.updateRibbonDisplay} /><br />
        <label className='font-format'>Ribbon Text</label>
        <input className='form-control' type='text' ref='ribbon_text' id='slide_ribbon' value={this.props.slide.ribbon}
          onChange={this.ribbonTextChange} />
        <label className='font-format'>Ribbon Color</label>
        <input value={this.props.slide.ribbon_color} type='color' ref='ribbon_color' id='slide_ribbon_color'
          onChange={this.ribbonColorChange} /><br />
        <label className='font-format'>Background URL</label>
        <input className='form-control' type='text' ref='custom_background' id='slide_custom_background' placeholder='Blank for Default Image' value={this.props.slide.custom_background === defaultCustomBg ? '' : this.props.slide.custom_background}
          onBlur={this.customBgChange} />
        <label className='font-format'>Display Rate</label>
        <input className='form-control' min='0' type='number' ref='display_rate' id='slide_display_rate' placeholder='Mark as 0 to place slide in random rotation' value={this.props.slide.display_rate}
          onChange={this.displayRateChange} />
        <label className='font-format'>Active?</label>
        <input className='form-check' type='checkbox' checked={this.props.slide.active ? 'checked' : ''} ref='active' id='slide_active'
          onClick={this.updateActive} /><br />
        <input type='button' value='Save Slide' className='font-format button' onClick={this.saveSlide} />
        <input type='button' value='Cancel' className='font-format button' onClick={this.discardChanges} />
      </div>
    )
  }
})
