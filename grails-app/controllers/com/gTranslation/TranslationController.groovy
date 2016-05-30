package com.gTranslation

import com.gTranslation.command.ListTranslationCommand
import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TranslationController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def translationService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Translation.list(params), model:[translationCount: Translation.count()]
    }

    def list(){
        def translations = translationService.getTranslations(params)
        def results = [total:translations.totalCount, rows:translations]
        render results as JSON
    }

    def listbysource(){
        def translations = translationService.getTranslationsBySourceValue(params)
        def results = [total:translations.totalCount, rows:translations]
        JSON.use('TranslationWithCategory') {
            render results as JSON
        }
    }

    def show(Translation translation) {
        respond translation
    }

    def create() {
        respond new Translation(params)
    }

    @Transactional
    def save(Translation translation) {
        if (translation == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (translation.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond translation.errors, view:'create'
            return
        }

        translation.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'translation.label', default: 'Translation'), translation.id])
                redirect translation
            }
            '*' { respond translation, [status: CREATED] }
        }
    }

    def editComponent(Translation translation) {
        respond translation
    }
    def edit(Translation translation) {
        respond translation
    }

    @Transactional
    def update(Translation translation) {
        if (translation == null) {
            transactionStatus.setRollbackOnly()
            flash.error=true
            notFound()
            return
        }
        if (translation.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond translation.errors, view:'editComponent'
            return
        }
        translation.save flush:true
        flash.message = message(code: 'default.updated.message', args: [message(code: 'translation.label', default: 'Translation'), translation.id])
        respond translation, view:'editComponent'

    }

    @Transactional
    def delete(Translation translation) {

        if (translation == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        translation.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'translation.label', default: 'Translation'), translation.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'translation.label', default: 'Translation'), params.id])
                render template: 'message'
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
