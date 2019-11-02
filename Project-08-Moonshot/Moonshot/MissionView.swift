//
//  MissionView.swift
//  Moonshot
//
//  Created by Frank Guchelaar on 02/11/2019.
//  Copyright © 2019 Awesomation. All rights reserved.
//

import SwiftUI

struct MissionView: View {

    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    let mission: Mission
    let astronauts: [CrewMember]

    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        self.astronauts = mission.crew.map { crewRole in
            guard let astronaut = astronauts.first(where: {$0.id == crewRole.name}) else {
                fatalError("Missing: \(crewRole.name)")
            }

            return CrewMember(role: crewRole.role, astronaut: astronaut)
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7 )

                    Text(self.mission.description)
                        .padding()
                        .layoutPriority(1)

                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))

                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName))
    }
}

struct MissionView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")

    static var previews: some View {
        MissionView(mission: missions.last!, astronauts: astronauts)
    }
}
