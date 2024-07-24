const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,html,rb}',
    './app/components/**/*.{js,erb,html,rb}'
  ],
  // With TailwindCSS-Rails 2.6.3 classes from .rb variants are not getting included consistently
  safelist: [
   // 'md:w-1/2',
    //'translate-x-full'
  ],
  darkMode: 'class',
  theme: {
    extend: {
      typography: ({ theme }) => ({
        blog: {
          css: {
            '--tw-format-links': theme('colors.primary[500]')
          }
        }
      }),
      colors: {
        primary: {
          "50": "var(--color-primary-50)",
          "100": "var(--color-primary-100)",
          "200": "var(--color-primary-200)",
          "300": "var(--color-primary-300)",
          "400": "var(--color-primary-400)",
          "500": "var(--color-primary-500)",
          "600": "var(--color-primary-600)",
          "700": "var(--color-primary-700)",
          "800": "var(--color-primary-800)",
          "900": "var(--color-primary-900)",
          "950": "var(--color-primary-950)"
        }
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    // require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    require("flowbite-typography"),
  ]
}
