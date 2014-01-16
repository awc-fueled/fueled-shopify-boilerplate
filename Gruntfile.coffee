module.exports = (grunt) ->

# Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    files:
      grunt:     ['gruntfile.js']
      css:       ['assets/*.css', 'assets/*.css.liquid']
      scss:      ['src/scss/**/*.scss']
      js:        ['src/js/vendor/**/*.js', 'src/js/custom/**/*.js'] #(if we need liquid templating), 'src/js/**/*.js.liquid', 'assets/**/*.js.liquid']
      coffee:    ['src/js/coffee/**/*.coffee', 'src/js/coffee/**/*.coffee.liquid']
      img:       ['src/images/**/*.{png,jpeg,svg,jpg,gif}', 'src/images/*.{png,jpeg,svg,jpg,gif}']

# tasks are listed in the order in wich they are proccesed. Expections are noted. 

# JavaScript Processing
    coffee:
      app:
        expand: true
        cwd: 'src/js/coffee/'
        src: ['**/*.coffee', '**/*.coffee.liquid']
        dest: 'src/js/custom'
        ext: '.js'

    # resulting js files and other custom js files are concatonated with concat:js and placed in.
    # 'src/js/concat/z.scripts.concat.js' for further processing.

    jshint:
      files: ['<%= files.grunt %>', 'src/js/z.scripts.concat.js']

      options:
        jquery: true
        smarttabs: true
        curly: true
        eqeqeq: true
        immed: true
        latedef: true
        newcap: true
        noarg: true
        sub: true
        undef: true
        boss: true
        eqnull: true
        browser: true

      globals:
        jQuery: true
        console: true
        undef: true
        unused: false

    uglify:
      dist:
        src: ['src/js/concat/z.scripts.concat.js']
        dest: 'assets/scripts.min.js'

# CSS Processing
    compass:
      dist:
        options:
          sassDir: 'src/scss'
          cssDir: 'src/scss/css'
          imagesDir: 'assets'
          javascriptsDir: 'assets'
          outputStyle: 'expanded'

    # Autoprefixer Processing - the absolute tits
    autoprefixer:
      options:
        browser: ['last 2 versions']
      multiple_files:
        expand: true
        flatten: true
        src: 'src/scss/css/*.css', # -> src/css/file1.css, src/css/file2.css
        dest: 'src/scss/prefix/' # -> dest/css/file1.css, dest/css/file2.css

    # concat:css runs. 

    cssmin:
      minify:
        src: 'src/scss/concat/z.styles.concat.css'
        dest: 'assets/styles.min.css.liquid'


# Concatenation Processing
    concat:
      css:
        src: ['src/scss/prefix/*.css']
        dest: 'src/scss/concat/z.styles.concat.css'

      js:
        src: ['<%= files.js %>']
        dest: 'src/js/concat/z.scripts.concat.js'

# Shell Commands
    shell:
      touchCSS:
        command: [
                    'sleep 0.3 ',
                    'touch assets/styles.min.css.liquid',
                    'sleep 0.3 ',
                    'touch assets/scripts.min.js',
                ].join(' && ')

# watch tasks
    watch:
      options:
        nospawn: true
        events: ['changed', 'added']
      files: [
                '<%= files.js %>'
                '<%= files.img %>'
                '<%= files.coffee %>'
                '<%= files.scss %>'
            ]
      tasks: ['default']

# MSC Tasks
# Clean Task
    clean: 
      assets:
        src: ['assets/*.*']
      scss:
        src: ['src/scss/concat/*.*', 'src/scss/prefix/*.*']
      css:
        src: ['src/scss/css/*.*']
      js:
        src: ['src/js/concat/*.*']


# Image Processing
    smushit:
      path:
        src: '<%= files.img %>'  #recursively replace minified images
        dest: 'assets'


# Use matchdep to register all tasks dynamicaly form package.json file.
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)


# Default task.
  grunt.registerTask 'default', [
                      'coffee'
                      'concat:js'
                      'jshint'
                      'uglify'
                      'compass'
                      'autoprefixer'
                      'concat:css'
                      'cssmin'
                      'shell'
                    ]

# Run the default task then losslessly minify images with Yahoo!'s Smush-It
  grunt.registerTask 'minify', ['default', 'smushit']

# Clear task
  grunt.registerTask 'clear', ['clean']