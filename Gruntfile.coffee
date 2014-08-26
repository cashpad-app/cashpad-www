module.exports = (grunt) ->
  require('load-grunt-tasks') grunt
  require('time-grunt') grunt

  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-bower-install'

  grunt.initConfig
    clean: [
      'dist/*',
      '.tmp'
    ]

    copy:
      dist:
        files: [
          expand: true
          cwd: 'app'
          dest: 'dist/',
          src: ['index.html']
        ,
          expand: true
          cwd: 'app'
          dest: '.tmp/',
          src: ['**/*.js']
        ]
      nomin:
        files: [
          dest: 'dist/vendor.js'
          src: [ '.tmp/concat/vendor.js' ]
        ,
          dest: 'dist/app.js',
          src: [ '.tmp/concat/app.js' ]
        ]

    coffee:
      dist:
        files:
          '.tmp/coffeed.js': ['app/app.coffee', 'app/**/*.coffee']
      test:
        files: # TODO
          'test/spec/coffeed.js': 'test/spec/**/*.coffee'

    jshint:
      options:
        jshintrc: '.jshintrc',
        reporter: require 'jshint-stylish'
      all: [
        'app/**/*.js',
        '!app/coffeed.js'
      ]

    bowerInstall:
      dist:
        src: 'app/index.html'
        cwd:  '.'
        ignorePath: 'app/'
        exclude: [
          'bower_components/requirejs',
          'bower_components/requirejs-plugins',
          'bower_components/ace-builds'
        ]

    jade:
      dist:
        files: [
          expand: true
          cwd: 'app/'
          src: '**/*.jade'
          dest: 'dist/'
          ext: '.html'
        ]

    sass:
      dist:
        options:
          style: 'expanded'
          loadPath: '.'
        files: [
          expand: true
          cwd: 'app'
          dest: '.tmp/'
          src: '**/*.scss'
          ext: '.css'
        ]

    useminPrepare:
      html: 'app/index.html',
      options:
        dest: 'dist'

    usemin:
      html: ['dist/index.html'],
      css: [],
      options:
        assetsDirs: ['.tmp']

    ngAnnotate:
      dist:
        files: [
          expand: true
          cwd: '.tmp/concat/'
          src: '**/*.js'
          dest: '.tmp/concat/'
        ]

    watch:
      dist:
        files: [
          'Gruntfile.coffee',
          'app/index.html',
          'app/**/*.js',
          'app/**/*.coffee',
          'app/**/*.jade'
        ]
        tasks: ['build']

    karma:
      unit:
        configFile: 'karma.conf.js'
        singleRun: true

  grunt.registerTask 'test', [
    'coffee:test',
    'karma:unit'
  ]

  grunt.registerTask 'build', [
    'bowerInstall',
    'newer:jshint:all',
    'test',
    'clean',
    'useminPrepare',
    'copy',
    'sass',
    'jade',
    'coffee:dist',
    'concat:generated',
    'ngAnnotate',
    'uglify:generated',
    # 'copy:nomin',
    'cssmin:generated',
    'usemin'
  ]

  grunt.registerTask 'default', ['build']
