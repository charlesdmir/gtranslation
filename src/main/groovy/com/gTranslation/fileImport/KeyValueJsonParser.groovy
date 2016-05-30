package com.gTranslation.fileImport

import com.gTranslation.Project
import com.gTranslation.SourceValue
import groovy.json.JsonSlurper

/**
 * Created by llevy on 11/17/15.
 */
class KeyValueJsonParser extends ImportParser {


    @Override
    def parse(InputStream stream, Project project) {

        def slurper = new JsonSlurper()
        def result = slurper.parse(stream, "UTF-8")
        def list = []

        result.each { key, value ->
            String sourceValue = ""
            String comment = ""
            Integer characterLimit = 0
            if (value instanceof Map) {
                value.each { nestedKey, nestedValue ->
                    if ("value".equals(nestedKey)) {
                        sourceValue = nestedValue
                    }
                    if ("comment".equals(nestedKey)) {
                        comment = nestedValue
                    }
                    if ("character_limit".equals(nestedKey)) {
                        //FIXME validate if characterLimit is a valid number
                        characterLimit = nestedValue as Integer
                    }
                }

            } else {
                sourceValue = value
            }

            list.add(super.createSourceValue(key, sourceValue, comment, characterLimit, project))

        }
        return list
    }

    @Override
    def parse(File file, Project project) {
        return null
    }
}
