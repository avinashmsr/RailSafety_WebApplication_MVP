<template>
  <v-footer
    id="pages-core-footer"
    absolute
    color="transparent"
    dark
  >
    
  </v-footer>
</template>

<script>
  export default {
    name: 'PagesCoreFooter',

    data: () => ({
      links: [
        {
          href: '#',
          text: 'Creative Tim'
        },
        {
          href: '#',
          text: 'About Us'
        },
        {
          href: '#',
          text: 'Blog'
        },
        {
          href: '#',
          text: 'Licenses'
        }
      ]
    })
  }
</script>

<style lang="sass">
  #pages-core-footer
    a
      color: #FFFFFF
      font-size: .825rem
      font-weight: 500
      text-decoration: none
      text-transform: uppercase
</style>
