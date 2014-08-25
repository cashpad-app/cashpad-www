module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)
  require('time-grunt')(grunt)

  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-bower-install'

  grunt.initConfig
    clean: ['dist/*']

    copy:
      dist:
        files: [
          expand: true
          cwd: 'app'
          dest: 'dist/',
          src: 'index.html'
        ]

    coffee:
      dist:
        files:
          'app/coffeed.js': 'app/**/*.coffee'
      test:
        files:
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

    jade:
      dist:
        files: [
          expand: true
          src: 'app/**/*.jade'
          dest: 'dist'
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
          dest: 'dist/style.css'
          src: [
            '**/*.scss'
          ]
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
        assetsDirs: ['app']

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
          'app/**/*.js',
          '!app/coffeed.js',
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
    'newer:jshint',
    'test',
    'clean',
    'useminPrepare',
    'copy:dist',
    'sass',
    'jade',
    'coffee:dist',
    'concat',
    'ngAnnotate',
    'uglify',
    'usemin'
  ]

  grunt.registerTask 'default', ['build']
  grunt.registerTask 'watch', ['build', 'watch']
