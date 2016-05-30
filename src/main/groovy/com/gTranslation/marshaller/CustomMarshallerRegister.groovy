package com.gTranslation.marshaller

import com.gTranslation.Comment
import com.gTranslation.Translation
import com.gTranslation.User
import com.gTranslation.util.CategoryUtil
import com.gTranslation.util.TranslationStatus
import grails.converters.JSON
import grails.util.Holders

import javax.annotation.PostConstruct
import java.text.SimpleDateFormat

/**
 * Created by pgarcia on 11/13/15.
 */
class CustomMarshallerRegister {

    def springSecurityService = Holders.grailsApplication.mainContext.getBean('springSecurityService')

    @PostConstruct
    void registerMarshallers() {
        JSON.registerObjectMarshaller(Date) {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            return format.format(it)
        }

        JSON.registerObjectMarshaller(Translation) {
            def map= [:]
            map['id'] = it.id
            map['sourceValue'] = it.sourceValue.defaultValue
            map['key'] = it.sourceValue.key
            map['lastModified'] = it.lastModified
            map['status'] = TranslationStatus.getStatusText(it.status)
            map['translation'] = it.value? it.value : ''
            map['assignedTo'] = it.assignedTo?.username
            return map
        }

        JSON.createNamedConfig('TranslationWithCategory') {
            it.registerObjectMarshaller( Translation ) { Translation translation ->
                def map = [:]
                map['id'] = translation.id
                map['sourceValue'] = translation.sourceValue.defaultValue
                map['key'] = translation.sourceValue.key
                map['category'] = CategoryUtil.getCategoryNameWithLocale(translation.category)
                map['lastModified'] = translation.lastModified
                map['status'] = TranslationStatus.getStatusText(translation.status)
                map['translation'] = translation.value ? translation.value : ''
                map['assignedTo'] = translation.assignedTo?.username
                return map
            }
        }

        JSON.registerObjectMarshaller(Comment) {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            User currentUser = springSecurityService.currentUser
            def map= [:]
            map['id'] = it.id
            map['parent'] = it.parent?.id
            map['created'] = format.format(it.created)
            map['modified'] = format.format(it.modified)
            map['content'] = it.content
            map['fullname'] = it.username
            map['created_by_admin'] = it.username == 'admin'? true : false
            map['created_by_current_user'] = currentUser.username == it.username? true : false
            map['upvote_count'] = it.upvoteCount
            map['user_has_upvoted'] = it.userHasUpvoted
            //todo: add  url in user domain
            map['profile_picture_url'] = 'https://app.viima.com/static/media/user_profiles/user-icon.png'
            return map
        }
    }

}
