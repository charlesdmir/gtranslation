package com.gTranslation

import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.CREATED

@Secured(['IS_AUTHENTICATED_REMEMBERED'])
class ImportController {
    def springSecurityService
    FileImportService fileImportService
    def index() {}

    def upload(Project project) {
        render (view: "upload", model: [project: project])
    }

    def uploadSourceFile(Project project) {

        def uploadedFile = request.getFile('file_source')

        if (!uploadedFile?.filename?.trim()) {
            flash.errorMessage = message(code: 'file.upload.empty', default: '')
            render(view:'upload', model:[project: project])
            return
        }
        def user = springSecurityService.currentUser
        def sourceValues = fileImportService.importSourceValues(user, project, request.getParameterMap(), uploadedFile.getInputStream())

        if (!sourceValues) {
            render (view:'upload', model:[project: project])
            return
        }

        //FIXME
        // if (sourceValue.hasErrors()) {
        //    respond sourceValue.errors, view:'create', model: [project: project]
        //    return
        //}

        flash.message = message(code: 'file.upload.success', default: 'File uploaded successfully')
        redirect(controller: "sourceValue", action: "index", params:['project.id': project.id])

    }

}
