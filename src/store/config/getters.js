import cacheStore from "../cacheStore";
const getters = {
    getDiligence(state, diligenceId)
    {
        var diligence = {};
        for (var i = 0; i < state.diligences.length; i++)
        {
            if (state.diligences[i].diligence_id === diligenceId)
            {
                diligence = state.diligences[i];
                diligence.details = state.diligenceDetails;
            }
        }

        return diligence;
    },
    getDiligenceActifs(state)
    {
        return state.diligenceDetails.actifs;
    },
    getClient(state)
    {
        var client = state.client;
        if (Object.keys(client).length < 1)
        {
            /** recuperer du cache */
            client = cacheStore.get("client");
            state.client = client;
        }
        return state.client;
    },
    getDiligenceTypes(state)
    {
        var diligenceTypes = state.diligenceTypes;
        if (diligenceTypes.length < 1)
        {
            /**
             * Récuperer les données stockées dans le cache.
             */
            diligenceTypes = cacheStore.get("diligence_types");
        }

        return diligenceTypes;
    },
    getActifs(state)
    {
        let actifs = state.actifs;
        if (actifs.length < 1)
        {
            //Réperation des actifs stockés dans le cache du navigateur !
            actifs = cacheStore.get("actifs");
        }

        return actifs;
    },
    getDiligences(state)
    {
        /**
         * Recuperer les données diligence stockées dans le cache.
         * @type {*|null}
         */
        var diligences=cacheStore.get("diligences");

        if (diligences !== null || diligences !== undefined)
        {
            state.diligences = diligences;
        }

        return state.diligences;
    },
    getQuestionnaire(state)
    {
        var questions = state.diligenceDetails.questionnaire.questions;
        /**
         * Melanger les questions et les questions additionnelles si cela existe.
         */
        try
        {
            var additionnel = state.diligenceDetails.questionnaire.additionel;

            if (additionnel.length > 0)
            {
                questions = questions.concat(additionnel);
            }
            //console.clear();
            //console.log(questions);
        } catch (error)
        {
            console.log("additionel exception");
            console.log(error);
        }
        return questions;
    },
    getQuestionsAdditionnel(state)
    {
        try
        {
            var additionnel = state.diligenceDetails.questionnaire.additionnel;
        } catch (error)
        {
            return [];
        }

        return additionnel;
    },
    getQuestionsCompletion(state)
    {
        return state.diligenceDetails.questionnaire.completion;
    },
    getCredits(state)
    {
        return state.diligenceDetails.credits;
    }
};

export default getters;
