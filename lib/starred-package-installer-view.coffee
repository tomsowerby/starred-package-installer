{View} = require 'atom'
{spawn} = require 'child_process'

module.exports =
class StarredPackageInstallerView extends View
  @content: ->
    @div class: 'starred-package-installer overlay from-top', =>
      @div "Starred Package Installer running (see console for details)", class: "message", outlet: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "starred-package-installer:run", => @run()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  cleanup: =>
    @destroy()

  run: ->
    console.log "StarredPackageInstallerView was toggled!"
    atom.workspaceView.append(this)
    ls = spawn 'apm', ['stars', '--install']
    # receive all output and process
    ls.stdout.on 'data', (data) -> console.log data.toString().trim()
    ls.stdout.on 'data', (data) => if data.toString().trim().indexOf '[' is -1 then @message.text(data.toString().trim())
    # receive error messages and process
    ls.stderr.on 'data', (data) -> console.log data.toString().trim()

    ls.on 'exit', (code) => @message.text('All Done') if code is 0
    ls.on 'exit', => setTimeout(@cleanup, 4000)
