package com.gTranslation

class TeamService {

    def getTeams(def params) {
        def results = Team.createCriteria().list(sort: params.sort, order: params.order, max: params.max, offset: params.offset) {
            if (params.name)
                ilike('name', '%'+ params.name+ '%')
        }
        return results
    }
}
