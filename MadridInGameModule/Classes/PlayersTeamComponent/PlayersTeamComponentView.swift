//
//  PlayersTeamComponentView.swift
//  CalendarComponent
//
//  Created by Arnau Rivas Rivas on 17/10/24.
//

import SwiftUI

struct PlayersTeamComponentView: View {
    let teamSelected: TeamModel
    
    @State var playerSelectedToRemove: PlayerModel?
    @State var isRemoveCellPressed: Bool = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(edges: .all)
            VStack (alignment: .leading, spacing: 20) {
                titleBanner
                listOfAllPlayersComponent
                applyForAdmissionComponent
                
            }
            .padding()
            
            CustomPopup(isPresented: Binding(
                get: { isRemoveCellPressed },
                set: { isRemoveCellPressed = $0 }
            )) {
                CancelOrDeleteComponent(title: "ELIMINAR JUGADOR", subtitle: "¿Seguro que quieres eliminar al jugador \"\(playerSelectedToRemove?.name ?? "NO NAME")\" ?") {
                    isRemoveCellPressed = false
                } aceptedAction: {
                    isRemoveCellPressed = false
                    //TODO: Delete player from the team into the Backend
                }
            }
            .transition(.scale)
            .zIndex(1)
        }
    }
}



extension PlayersTeamComponentView {
    private var titleBanner: some View {
        Text("JUGADORES")
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(Color.white)
    }
    
    private var listOfAllPlayersComponent: some View {
        ScrollView {
            LazyVStack {
                ForEach(teamSelected.allPlayersAssigned, id: \.id) { player in
                    PlayerTeamComponentCell(playerInformation: player, allRolesAvailable: teamSelected.allRolesAvailable, removeAction: { playerSelected in
                        self.playerSelectedToRemove = playerSelected
                        self.isRemoveCellPressed = true
                    })
                    .padding(.top, 10)

                }
            }
        }
    }
    
    private var applyForAdmissionComponent: some View {
        HStack {
            Spacer()
            VStack (spacing: 40){
                CustomButton(text: "No tienes solicitudes",
                             needsBackground: false,
                             backgroundColor: Color.cyan,
                             pressEnabled: true,
                             widthButton: 250, heightButton: 30) {
                }
                
                CustomButton(text: "Invitar al equipo",
                             needsBackground: true,
                             backgroundColor: Color.cyan,
                             pressEnabled: true,
                             widthButton: 250, heightButton: 30) {
                    
                }
            }
            Spacer()
        }
        .padding()
    }
}