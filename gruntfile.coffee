module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-bower-concat'
  grunt.loadNpmTasks 'grunt-mocha-phantomjs'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-este-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-typescript'
  grunt.initConfig
    bower_concat:
      all:
        dest: 'public/vendor.js'
        dependencies:
          'chai-jquery': ['jquery','chai']
        bowerOptions:
          relative: false

    typescript:
      app:
        src: ['app/ts/index.ts']
        dest: 'public/ts.js'
        options:
          module: 'commonjs'
          target: 'es5'
          sourceMap: true

    browserify:
      coffee:
        files:
          'public/cs.js': [
            'app/coffee/initialize.coffee'
          ]
        options:
          debug: true
          transform: ['coffeeify']

      test:
        files:
          'test/assets/test.js': [
            'test/initialize.coffee'
          ]
        options:
          debug: true
          transform: ['coffeeify']

    mocha_phantomjs:
      options:
        reporter: 'spec'
      all: ['test/assets/test.html']

    esteWatch:
      options:
        dirs: ['app/**/', 'test/**/']
      coffee: (filepath) ->
        console.log filepath
        if /app/.test(filepath)
          ['browserify:coffee']
        else if /test/.test(filepath)
          ['browserify:coffee', 'browserify:test', 'mocha_phantomjs']

      ts: (filepath) ->
        console.log filepath
        ['typescript:app']

    connect:
      app:
        options:
          port: 8888
          base: 'public'

  grunt.registerTask "build", ["bower_concat", "browserify", "typescript"]
  grunt.registerTask "test-build", ["bower_concat", "browserify:coffee", "typescript"]
  grunt.registerTask "default", ["build"]
  grunt.registerTask "test", ["build", "mocha_phantomjs"]
  grunt.registerTask "server", ["build", "connect", "esteWatch"]
