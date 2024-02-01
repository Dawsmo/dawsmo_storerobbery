var uiVisible = false;
var currentQuests = {}; // Stocke les quêtes actuelles

window.addEventListener('message', function (event) {
    var item = event.data;

    if (item.showUI && !item.update) {
        uiVisible = true;
        $('.menu-container').show();

        if (item.quests) {
            currentQuests = item.quests; // Stocker les quêtes actuelles
            configureQuests(currentQuests);
        }
    } else if (!item.showUI && !item.update) {
        uiVisible = false;
        $('.quest-list').empty(); // Vidage de la liste des quêtes
        $('.menu-container').hide();
    } else if (item.update && uiVisible) {
        // Mise à jour des quêtes uniquement si l'UI est visible
        if (item.quests) {
            currentQuests = item.quests; // Mettre à jour les quêtes actuelles
            configureQuests(currentQuests)
        }
    }
});

function openUI(quests) {
    $('.menu-container').show();

    // Ajouter du code pour configurer les quêtes
    if (quests) {
        currentQuests = quests; // Stocker les quêtes actuelles
        configureQuests(currentQuests);
    }
}

function closeUI() {
    uiVisible = false;
    $('.quest-list').empty(); // Vidage de la liste des quêtes
    $('.menu-container').hide();
    $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
}

function configureQuests(quests) {
    // Supprimer le contenu actuel de la quête pour éviter les duplications
    $('.quest-list').empty();

    // Définir l'ordre des quêtes
    var questOrder = ["CashRegister", "StoreShelves", "Safe"];

    // Trier les quêtes en fonction de l'ordre spécifié
    questOrder.forEach(function(questName) {
        if (quests.hasOwnProperty(questName)) {
            var quest = quests[questName];
            addQuest(questName, quest);
        }
    });
}


function addQuest(questName, quest) {
    // Vérifier si maxToRob est différent de 0 avant d'ajouter la quête
    if (quest.maxToRob !== 0) {
        var questItem = $('<div class="quest-item">');
        var questImage = $(`<img src="/src/img/${questName.toLowerCase()}.png" alt="${questName} Icon">`);
        var questProgress = $(`<span class="quest-progress">${quest.currentRobbed}/${quest.maxToRob}</span>`);

        questItem.append(questImage);
        questItem.append(questProgress);

        if (questName === 'Safe') {
            $('.quest-list').append('<div class="separator"></div>');
        }

        $('.quest-list').append(questItem);

        if (questName === 'Safe') {
            var pinQuest = $('<div class="quest-item">');
            var pinImage = $('<img src="/src/img/pin.png" alt="Pin Icon">');
            var pinProgress;

            if (quest.forced) {
                pinProgress = $(`<span class="quest-progress">${quest.code[0]} / ${quest.code[1]} / ${quest.code[2]}</span>`);
            } else {
                pinProgress = $(`<span class="quest-progress">** / ** / **</span>`);
            }

            pinQuest.append(pinImage);
            pinQuest.append(pinProgress);
            $('.quest-list').append(pinQuest);
        }
    }
}



function updateQuests(quests) {

    for (var questName in quests) {
        if (quests.hasOwnProperty(questName)) {
            var quest = quests[questName];
            var existingQuest = $('.quest-list').find(`img[alt="${questName} Icon"]`).siblings('.quest-progress');
            existingQuest.text(`${quest.currentRobbed}/${quest.maxToRob}`);
        }
    }
}
