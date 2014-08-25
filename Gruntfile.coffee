module.exports = (grunt) ->
  require('load-grunt-tasks') grunt
  require('time-grunt') grunt

  grunt.initConfig
    coffee:
      dist:
        files:
          'app/coffeed.js': 'app/**/*.coffee'

    jshint:
      options:
        jshintrc: '.jshintrc',
        reporter: require 'jshint-stylish'
      all: [
        'Gruntfile.js',
        'app/{,*/}*.js'
      ]

    clean: ['dist']

    ngAnnotate:
      dist:
        files: [
          expand: true
          cwd: 'dist'
          src: 'app.js'
          dest: 'dist'
        ]

    concat:
      dist:
        dest: 'dist/app.js'
        src: ['app/**/*.js']

    jade:
      dist:
        files: [
          expand: true
          src: 'app/**/*.jade'
          dest: 'dist'
          ext: '.html'
        ]

    watch:
      dist:
        files: [
          'app/**/*.js',
          '!app/cofeed.js',
          'app/**/*.coffee',
          'app/**/*.jade'
        ]
        tasks: ['build']

    # karma:
    #   unit:
    #     configFile: 'karma.conf.js'
    #     singleRun: true

  grunt.registerTask 'build', [
    'newer:jshint',
    'clean',
    'jade',
    'coffee',
    'concat',
    'ngAnnotate'
  ]

  grunt.registerTask 'default', ['build']
  grunt.registerTask 'watch', ['build', 'watch']
