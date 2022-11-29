import cacheStore from "../cacheStore";
const mutations = {
    setUser: function(state, data)
    {
        /**
         * Sauvegarder aussi dans la mémoire sessionStorage du navigateur
         */
        sessionStorage.setItem("user", JSON.stringify(data));
        localStorage.setItem("user", JSON.stringify(data));

        state.user = data; /** sauvegarder dans le store */
    },
    setConfigs: (state, data) => state.configs = data,
    setDiligences(state,data)
    {
        /**
         * Sauvegarder dans le cache
         */
        cacheStore.save("diligences",data);

        state.diligences=data;
    },
    setDiligenceDetails(state,data)
    {

        state.diligenceDetails=data;
    },
    setClient(state, data)
    {
        cacheStore.save("client", data);
        state.client = data;
    },
    setDiligenceTypes(state, data)
    {
        cacheStore.save("diligence_types", data);
        state.diligenceTypes = data;
    },
    setActifs(state, actifs)
    {
        cacheStore.save("actifs", actifs);
        state.actifs = actifs;
    }
};

export default mutations;
