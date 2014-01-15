module.exports = (grunt) ->

# Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    files:
      grunt:     ['gruntfile.js']
      css:       ['assets/styles.css.liquid', 'assets/screen.prefixed.css']
      scss:      ['src/scss/**/*.scss']
      js:        ['src/js/vendor/**/*.js', 'src/js/custom/**/*.js'] #(if we need liquid templating), 'src/js/**/*.js.liquid', 'assets/**/*.js.liquid']
      coffee:    ['src/js/coffee/**/*.coffee', 'src/js/coffee/**/*.coffee.liquid']
      img:       ['src/images/**/*.{png,jpeg,svg,jpg,gif}', 'src/images/*.{png,jpeg,svg,jpg,gif}']

# Image Processing
    smushit:
      path:
        src: '<%= files.img %>'  #recursively replace minified images
        dest: 'assets'

# Concatenation Processing
    concat:
      css:
        src: ['<%= files.css %>']
        dest: 'assets/z.styles.concat.css.liquid'

      js:
        src: ['<%= files.js %>']
        dest: 'src/js/concat/z.scripts.concat.js'

# Autoprefixer Processing - the absolute tits
    autoprefixer:
      options:
        browser: ['last 2 versions']

      single_file:
        src: 'assets/screen.css'
        dest: 'assets/screen.prefixed.css'

# JavaScript Processing
    coffee:
      app:
        expand: true
        cwd: 'src/js/coffee/'
        src: ['**/*.coffee', '**/*.coffee.liquid']
        dest: 'src/js/custom'
        ext: '.js'

    uglify:
      dist:
        src: ['src/js/concat/z.scripts.concat.js']
        dest: 'assets/scripts.min.js'

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



# CSS Processing
    compass:
      dist:
        options:
          sassDir: 'src/scss'
          cssDir: 'assets'
          imagesDir: 'assets'
          javascriptsDir: 'assets'
          outputStyle: 'expanded'

    cssmin:
      minify:
        src: 'assets/z.styles.concat.css.liquid'
        dest: 'assets/styles.min.css.liquid'

# Shell Commands
    shell:
      touchCSS:
        command: [
                    'sleep 0.3',
                    'touch assets/z.styles.concat.css.liquid'
                ].join('&&')

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

# Use matchdep to register all tasks dynamicaly form package.json file.
 require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);


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

# Minify task

# Run the default task then losslessly minify images with Yahoo!'s Smush-It

  grunt.registerTask 'minify', ['default', 'smushit']