var Form = React.createClass({
  saveSlide () {
    slide = this.props.slide
    $.ajax({
      url: '/api/v1/slides',
      type: 'POST',
      data: {slide: slide},
      success: (data) => {
        this.props.handleSlideSaving(data)
      }
    })
    this.props.handleSlideSaving()
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
    return (
      <div>
        <label className='font-format'>Title</label>
        <input className='form-control' type='text' ref='title' id='slide_title' onChange={this.titleChange} />
        <label className='font-format'>Subtitle</label>
        <input className='form-control' type='text' ref='subtitle' id='slide_subtitle' onChange={this.subtitleChange} />
        <label className='font-format'>Display Ribbon?</label>
        <input className='form-check' type='checkbox' value='1' checked={this.props.slide.ribbon_display ? 'checked' : ''} ref='ribbon_display' id='slide_ribbon_display'
          onClick={this.updateRibbonDisplay} /><br />
        <label className='font-format'>Ribbon Text</label>
        <input className='form-control' type='text' ref='ribbon_text' id='slide_ribbon' onChange={this.ribbonTextChange} />
        <label className='font-format'>Color of Ribbon</label>
        <input value={this.props.slide.ribbon_color} type='color' ref='ribbon_color' id='slide_ribbon_color' onChange={this.ribbonColorChange} /><br />
        <label className='font-format'>Custom Image URL (Leave Blank for Default Image)</label>
        <input className='form-control' type='text' ref='custom_background' id='slide_custom_background' onBlur={this.customBgChange} />
        <label className='font-format'>Display Rate (Mark as 0 to place slide in random rotation)</label>
        <input className='form-control' min='0' type='number' ref='display_rate' id='slide_display_rate' value={this.props.slide.display_rate} onChange={this.displayRateChange} />
        <label className='font-format'>Active?</label>
        <input className='form-check' type='checkbox' value='1' checked={this.props.slide.active ? 'checked' : ''} ref='active' id='slide_active'
          onClick={this.updateActive} /><br />
        <input type='button' value='Save Slide' className='font-format button' onClick={this.saveSlide} />
      </div>
    )
  }
})
