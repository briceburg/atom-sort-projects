
module.exports = SortProjects =
  onDidChangePathsSub: null

  sortProjects: (paths) ->
    paths.sort (a,b) ->
      a = a.replace( /.*[\/\\]/, "").toLowerCase()
      b = b.replace( /.*[\/\\]/, "").toLowerCase()
      if a < b then -1 else 1

    if atom.project.getPaths().toString() != paths.toString()
      atom.project.setPaths(paths)

  activate: (state) ->
    @onDidChangePathsSub = atom.project.onDidChangePaths(@sortProjects)

  deactivate: ->
    @onDidChangePathsSub.dispose()
