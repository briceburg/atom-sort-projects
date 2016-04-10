
{CompositeDisposable} = require 'atom'

module.exports = SortProjects =
  subscriptions: null
  onDidChangePathsSub: null

  sortProjects: (paths) ->
    paths.sort()
    atom.project.setPaths(paths) if (atom.project.getPaths().toString() != paths.sort().toString())

  activate: (state) ->
    console.log state
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-sort-projects:toggle': => @toggle()
    @toggle() if state.enabled

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->
    state = {}
    state.enabled = @onDidChangePathsSub != null
    return state

  toggle: ->
    if @onDidChangePathsSub == null
      @onDidChangePathsSub = atom.project.onDidChangePaths(@sortProjects)
      @sortProjects(atom.project.getPaths())
      console.log 'SortProjects enabled'
    else
      @onDidChangePathsSub.dispose()
      @onDidChangePathsSub = null
      console.log 'SortProjects disabled'
