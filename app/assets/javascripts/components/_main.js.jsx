var Main = React.createClass({
  componentWillMount () {
    if (this.props.slideId) {
      this.getSlideData(this.props.slideId)
    }
  },

  getInitialState () {
    return {
      slide: {
        title: '',
        subtitle: '',
        ribbon_display: false,
        ribbon: '',
        ribbon_color: '#000000',
        custom_background: 'https://static1.squarespace.com/static/5602b79ee4b0a65d125ea3c4/t/57b37b0bb3db2b80ee031840/1471380241780/DSC05223.jpeg',
        display_rate: '5',
        active: true
      }
    }
  },

  getSlideData (slideId) {
    $.ajax ({
      url: `/api/v1/slides/${slideId}`,
      type: 'GET',
      success: (data) => {
        var slide = data
        this.setState({ slide: data })
      }
    })
  },

  forgetIt () {
    window.location.href = '/admin/slides'
  },

  handleSlideSaving (data) {
    if (data.error) {
      console.log(data.error)
    } else {
      window.location.href = data.redirect_url
    }
  },

  handleTitleChange (value) {
    var newSlide = this.state.slide
    newSlide.title = value
    this.setState({ slide: newSlide })
  },

  handleSubtitleChange (value) {
    var newSlide = this.state.slide
    newSlide.subtitle = value
    this.setState({ slide: newSlide })
  },

  handleRibbonTextChange (value) {
    var newSlide = this.state.slide
    newSlide.ribbon = value
    this.setState({ slide: newSlide })
  },

  handleRibbonColorChange (value) {
    var newSlide = this.state.slide
    newSlide.ribbon_color = value
    this.setState({ slide: newSlide })
  },

  handleBgChange (value) {
    var defaultBg = 'https://static1.squarespace.com/static/5602b79ee4b0a65d125ea3c4/t/57b37b0bb3db2b80ee031840/1471380241780/DSC05223.jpeg'
    var newSlide = this.state.slide
    newSlide.custom_background = (value === '' ? defaultBg : value)
    this.setState({ slide: newSlide })
  },

  handleDisplayRateChange (value) {
    var newSlide = this.state.slide
    newSlide.display_rate = value
    this.setState({ slide: newSlide })
  },

  updateRibbonDisplay (active) {
    var newSlide = this.state.slide
    newSlide.ribbon_display = active
    this.setState({ slide: newSlide })
  },

  updateActive (active) {
    var newSlide = this.state.slide
    newSlide.active = active
    this.setState({ slide: newSlide })
  },

  render () {
    return (
      <div className='row'>
        <div className='col-md-4'>
          <Form slide={this.state.slide}
                updateRibbonDisplay={this.updateRibbonDisplay}
                updateActive={this.updateActive}
                handleTitleChange={this.handleTitleChange}
                handleSubtitleChange={this.handleSubtitleChange}
                handleRibbonTextChange={this.handleRibbonTextChange}
                handleRibbonColorChange={this.handleRibbonColorChange}
                handleBgChange={this.handleBgChange}
                handleDisplayRateChange={this.handleDisplayRateChange}
                handleSlideSaving={this.handleSlideSaving}
                forgetIt={this.forgetIt} />
        </div>
        <div className='col-md-8'>
          <Preview slide={this.state.slide} />
        </div>
      </div>
    )
  }
})
