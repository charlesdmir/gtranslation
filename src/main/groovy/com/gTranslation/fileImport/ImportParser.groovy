package com.gTranslation.fileImport

import com.gTranslation.Project
import com.gTranslation.SourceValue

/**
 * Created by llevy on 11/17/15.
 */
abstract class ImportParser {


    public abstract def parse(InputStream stream, Project project)
    public abstract def parse(File file, Project project)

    def createSourceValue(String key, String sourceValue, String comment, Integer characterLimit, Project project) {
        return new SourceValue(key: key,
                               defaultValue: sourceValue,
                               characterLimit: characterLimit,
                               comments: comment,
                               project: project)
    }

}