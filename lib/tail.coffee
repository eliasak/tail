TailView = require './tail-view'
# {CompositeDisposable} = require 'atom'

module.exports = Tail =
  tailView: null
  modalPanel: null
#  subscriptions: null

  isActivated: false
  subscDidStopChanging: null

  activate: (state) ->
    @tailView = new TailView(state.tailViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @tailView.getElement(), visible: false)
    atom.commands.add 'atom-workspace', "tail:toggle", => @toggle()

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
#    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
#    @subscriptions.add atom.commands.add 'atom-workspace', 'tail:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
#    @subscriptions.dispose()
    @tailView.destroy()

#  serialize: ->
#    tailViewState: @tailView.serialize()

  toggle: ->
    @isActivated = !@isActivated

    panel = @modalPanel

    if @isActivated
      editor = atom.workspace.getActivePaneItem()
      @subscDidStopChanging = editor.onDidStopChanging(() =>
        editor.moveToBottom()
        panel.show()

        setTimeout ->
          if panel.isVisible()
            panel.hide()
        , 2500
      )
    else
        @subscDidStopChanging.dispose()

#    console.log 'Tail was toggled!'
    # if @modalPanel.isVisible()
    #   @modalPanel.hide()
    # else
    #   @modalPanel.show()
