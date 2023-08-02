const defaultTheme = require('tailwindcss/defaultTheme')
const colors = require("tailwindcss/colors")

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    { raw: '<div class="bg-gray-900 bg-opacity-50 dark:bg-opacity-80 fixed inset-0 z-40">', extention: 'html' },
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        primary: colors.blue,
        secondary: colors.slate,
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
