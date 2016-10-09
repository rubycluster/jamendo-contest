define [
  'views/base/item_view'
  'templates/vote'
  'vent'
  'moment'
], (
  BaseItemView
  template
  vent
  moment
) ->

  class VoteView extends BaseItemView

    template: template

    el: '#vote'

    events:
      'click a.button': 'onVoteClick'

    onVoteClick: ->
      @markAsVoted()

    onBeforeRender: ->
      @hideView()

    onRender: ->

    showView: ->
      $(@el).slideDown('slow')
      @markAsShown()

    showViewIfValid: ->
      @isValidToShow() && @showView()

    isValidToShow: ->
      @isInContest() and !@isVoted() and !@isShown()

    isInContest: ->
      contestEndDate = '2013-06-24'
      now = moment()
      now.isBefore(contestEndDate)

    isShown: ->
      vent.data.vote_is_shown > 3

    markAsShown: ->
      vent.data.vote_is_shown ||= 0
      vent.data.vote_is_shown++

    isVoted: ->
      vent.data.vote_is_clicked is true

    markAsVoted: ->
      vent.data.vote_is_clicked = true
