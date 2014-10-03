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
          dest: 'dist/',
          src: ['images/**/*.{png,jpg,jpeg,gif}']
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
          'bower_components/ace-builds',
          'bower_components/sass-flex-mixins'
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
          loadPath: [
            '.',
            'bower_components'
          ]
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
      coffee:
        files: [
          'Gruntfile.coffee',
          'app/**/*.coffee',
        ]
        tasks: [
          'useminPrepare',
          'coffee',
          'concat:generated',
          'ngAnnotate',
          'copy:nomin',
          'cssmin:generated',
          'usemin'
        ]
      index:
        files: [
          'app/index.html'
        ]
        tasks: [
          'useminPrepare',
          'copy:dist',
          'usemin'
        ]
      js:
        files: [
          'app/**/*.js',
          'lib/**/*.js'
        ]
        tasks: [
          'newer:jshint:all',
          'useminPrepare',
          'copy:dist',
          'concat:generated',
          'copy:nomin',
          'usemin'
        ]
      jade:
        files: [
          'app/**/*.jade'
        ]
        tasks: ['jade']
      sass:
        files: [
          'app/**/*.scss'
        ]
        tasks: [
          'useminPrepare',
          'sass',
          'concat:generated',
          'cssmin:generated',
          'usemin'
        ]
      bower:
        files: [
          'bower.json'
        ]
        tasks: [
          'bowerInstall',
          'useminPrepare',
          'copy:dist',
          'sass',
          'concat:generated',
          'copy:nomin',
          'cssmin:generated',
          'usemin'
        ]

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
    'jshint:all',
    'test',
    'clean',
    'useminPrepare',
    'copy:dist',
    'sass',
    'jade',
    'coffee:dist',
    'concat:generated',
    'ngAnnotate',
    'uglify:generated',
    'cssmin:generated',
    'usemin'
  ]

  grunt.registerTask 'default', ['build']
