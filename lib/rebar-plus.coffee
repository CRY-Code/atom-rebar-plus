RebarPlusView = require './rebar-plus-view'
{CompositeDisposable} = require 'atom'

module.exports = RebarPlus =
  rebarPlusView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @rebarPlusView = new RebarPlusView(state.rebarPlusViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @rebarPlusView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'rebar-plus:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @rebarPlusView.destroy()

  serialize: ->
    rebarPlusViewState: @rebarPlusView.serialize()

  toggle: ->
    console.log 'RebarPlus was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
