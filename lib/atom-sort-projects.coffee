SortProjectsView = require './sort-projects-view'
{CompositeDisposable} = require 'atom'

module.exports = SortProjects =
  subscriptions: null
  onDidChangePathsSub: null

  sortProjects: (paths) ->
    paths.sort()
    atom.project.setPaths(paths) if (atom.project.getPaths().toString() != paths.sort().toString())

  activate: (state) ->

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'sort-projects:toggle': => @toggle()

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->

  toggle: ->
    if @onDidChangePathsSub == null
      @onDidChangePathsSub = atom.project.onDidChangePaths(@sortProjects)
      @sortProjects(atom.project.getPaths())
      console.log 'SortProjects enabled'
    else
      @onDidChangePathsSub.dispose()
      @onDidChangePathsSub = null
      console.log 'SortProjects disabled'
