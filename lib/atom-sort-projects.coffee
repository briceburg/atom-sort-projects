
{CompositeDisposable} = require 'atom'

module.exports = SortProjects =
  subscriptions: null
  onDidChangePathsSub: null

  sortProjects: (paths) ->
    paths.sort (a,b) ->
      a = a.split("/").slice(-1)[0].toLowerCase()
      b = b.split("/").slice(-1)[0].toLowerCase()
      if a > b then 1 else 0
    atom.project.setPaths(paths) if (atom.project.getPaths().toString() != paths.toString())

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-sort-projects:toggle': => @toggle()
    @toggle() if state.enabled

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->
    enabled: @onDidChangePathsSub != null

  toggle: ->
    if @onDidChangePathsSub == null
      @onDidChangePathsSub = atom.project.onDidChangePaths(@sortProjects)
      @sortProjects(atom.project.getPaths())
      console.log 'SortProjects enabled'
    else
      @onDidChangePathsSub.dispose()
      @onDidChangePathsSub = null
      console.log 'SortProjects disabled'
