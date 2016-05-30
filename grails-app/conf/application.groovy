// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'com.gTranslation.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'com.gTranslation.UserRole'
grails.plugin.springsecurity.authority.className = 'com.gTranslation.Role'
grails.plugin.springsecurity.securityConfigType = "Annotation"
grails.plugin.springsecurity.rejectIfNoRule = false
grails.plugin.springsecurity.fii.rejectPublicInvocations = false
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
        '/'              : ['permitAll'],
        '/error'         : ['permitAll'],
        '/index'         : ['permitAll'],
        '/index.gsp'     : ['permitAll'],
        '/debug'         : ['permitAll'],
        '/debug.gsp'     : ['permitAll'],
        '/shutdown'      : ['permitAll'],
        '/assets/**'     : ['permitAll'],
        '/**/js/**'      : ['permitAll'],
        '/**/css/**'     : ['permitAll'],
        '/**/images/**'  : ['permitAll'],
        '/**/favicon.ico': ['permitAll']
]
