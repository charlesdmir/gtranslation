import com.gTranslation.Category
import com.gTranslation.Project
import com.gTranslation.Role
import com.gTranslation.Team
import com.gTranslation.User
import com.gTranslation.UserRole
import com.gTranslation.util.Roles

class BootStrap {


    def init = { servletContext ->
        if (User.count() == 0) {
            initDB()
        }
    }
    private def initDB() {
        def adminRole = new Role(Roles.ADMIN).save()
        def coordinatorRole = new Role(Roles.COORDINATOR).save()
        def translatorRole = new Role(Roles.TRANSLATOR).save()
        def reviewerRole = new Role(Roles.REVIEWER).save()
        def contributorRole = new Role(Roles.CONTRIBUTOR).save()
        def guestRole = new Role(Roles.GUEST).save()

        def adminUser = new User('admin', 'password').save()
        def coordinatorUser = new User('coordinator', 'password').save()
        def translatorUser = new User('translator', 'password').save()
        def reviewerUser = new User('reviewer', 'password').save()
        def contributorUser = new User('contributor', 'password').save()
        def guestUser = new User('guest', 'password').save()
        def guestUser1 = new User('guest1', 'password').save()
        def guestUser2 = new User('guest2', 'password').save()
        def guestUser3 = new User('guest3', 'password').save()
        def guestUser4 = new User('guest4', 'password').save()
        def guestUser5 = new User('guest5', 'password').save()
        def guestUser6 = new User('guest6', 'password').save()


        UserRole.create adminUser, adminRole, true
        UserRole.create coordinatorUser, coordinatorRole, true
        UserRole.create translatorUser, translatorRole, true
        UserRole.create reviewerUser, reviewerRole, true
        UserRole.create contributorUser, contributorRole, true
        UserRole.create guestUser, guestRole, true
        UserRole.create guestUser1, guestRole, true
        UserRole.create guestUser2, guestRole, true
        UserRole.create guestUser3, guestRole, true
        UserRole.create guestUser4, guestRole, true
        UserRole.create guestUser5, guestRole, true
        UserRole.create guestUser6, guestRole, true


        def team = new Team(name:'Orbitz team')
        team.addToUsers(coordinatorUser)
        team.addToUsers(translatorUser)
        team.addToUsers(reviewerUser)
        team.addToUsers(contributorUser)
        team.save()

        def project = new Project(name:'System Texts', owner: coordinatorUser).save()

        team.addToProjects(project)
        team.save()

        project.save(flush:true)

        def usCategory = new Category(name: 'US Pos', project: project).save()
        def orbCategory = new Category(name:'Orbitz', project: project, parent: usCategory, isTranslatable: false).save()
        def orbEnUs = new Category(project: project, parent: orbCategory, isTranslatable: true, locale: java.util.Locale.US, useSourceValue: true).save()
        def orbEn = new Category(project: project, parent: orbCategory, isTranslatable: true, locale: java.util.Locale.ENGLISH).save()


        def ctixCategory = new Category(name:'CheapTickets', project: project, parent: usCategory, isTranslatable: true).save()
        def ctixEnUs = new Category(project: project, parent: ctixCategory, isTranslatable: true, locale: java.util.Locale.US).save()
        def ctixIt = new Category(project: project, parent: ctixCategory, isTranslatable: true, locale: java.util.Locale.ITALY).save()

        def euCategory = new Category(name: 'EU Pos', project: project).save()
        def ebukCategory = new Category(name:'Ebookers', project: project, parent:euCategory).save()
        def ebukEnGB = new Category(project: project, parent: ebukCategory, isTranslatable: true, locale: new java.util.Locale('en','GB')).save()
        def ebukES = new Category(project: project, parent: ebukCategory, isTranslatable: true, locale: new java.util.Locale('es','ES')).save()

        def hclCategory = new Category(name:'Hotel Club', project: project, parent: euCategory).save()
        def hclFrFR = new Category(project: project, parent: hclCategory, isTranslatable: true, locale: java.util.Locale.FRANCE).save()
        def hclkES = new Category(project: project, parent: hclCategory, isTranslatable: true, locale: new java.util.Locale('es','ES')).save()

        def hwCategory = new Category(name: 'HelloWorld', project: project).save()
        def hwEnGB = new Category(project: project, parent: hwCategory, isTranslatable: true, locale: new java.util.Locale('en','GB'), useSourceValue: true).save()
    }
    

    def destroy = {
    }
}
