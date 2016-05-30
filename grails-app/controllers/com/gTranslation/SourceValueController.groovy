package com.gTranslation

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured(['IS_AUTHENTICATED_REMEMBERED'])
class SourceValueController {

    SourceValueService sourceValueService;
    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Project project, Integer max) {
        if (project) {
            params.max = Math.min(max ?: 10, 100)
            def stats = sourceValueService.getSourceValuesStats(project, params)
            render view: 'index' , model:[sourceValueCount: stats.totalCount, project: project, stats: stats.results]
        } else {
            redirect(controller: "project", action: "index")
        }
    }

    def show(SourceValue sourceValue) {
        respond sourceValue, model:[project: sourceValue.project]
    }

    def create(Project project) {
        if (project) {
            respond new SourceValue(params), model: [project: project]
        } else {
            redirect(controller: "project", action: "index")
        }
    }

    @Transactional
    def save(Project project) {
        def user = springSecurityService.currentUser
        def sourceValue = sourceValueService.processSourceValue(user, project, params);
        if (sourceValue == null) {
            notFound(params)
            return
        }

        if (sourceValue.hasErrors()) {
            respond sourceValue.errors, view:'create', model: [project: project]
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'sourceValue.label', default: 'SourceValue'), sourceValue.id])
                redirect sourceValue
            }
            '*' { respond sourceValue, [status: CREATED] }
        }
    }

    def edit(SourceValue sourceValue) {
        respond sourceValue
    }

    @Transactional
    def update(SourceValue sourceValue) {
        if (sourceValue == null) {
            transactionStatus.setRollbackOnly()
            notFound(params)
            return
        }

        if (sourceValue.hasErrors()) {
            transactionStatus.setRollbackOnly()
            def project = Project.get(params.project.id)
            respond sourceValue.errors, view:'edit', model: [project: project]
            return
        }

        sourceValue.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'sourceValue.label', default: 'SourceValue'), sourceValue.id])
                redirect sourceValue
            }
            '*'{ respond sourceValue, [status: OK] }
        }
    }

    @Transactional
    def delete(SourceValue sourceValue) {

        if (sourceValue == null) {
            transactionStatus.setRollbackOnly()
            notFound(params)
            return
        }

        sourceValue.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'sourceValue.label', default: 'SourceValue'), sourceValue.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound(Project project) {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'sourceValue.label', default: 'SourceValue'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND, model: [project: project]}
        }
    }
}
