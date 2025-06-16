//
//  HolidayRowView.swift
//  LiveInTech
//
//  Created by Mekala Vamsi Krishna on 6/16/25.
//

import SwiftUI

struct HolidayRowView: View {
    let holiday: PublicHoliday

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            let formattedDate = formatDate(holiday.date)

            VStack {
                Text(formattedDate.day)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(formattedDate.month)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
            .frame(width: 50, height: 50)
            .background(Color.blue)
            .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) {
                Text(holiday.localName)
                    .font(.headline)
                if !holiday.types.isEmpty {
                    Text(holiday.types.joined(separator: ", "))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()
        }
        .padding(.vertical, 8)
    }

    func formatDate(_ dateStr: String) -> (day: String, month: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        guard let date = formatter.date(from: dateStr) else {
            return ("??", "??")
        }

        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"

        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMM"

        return (dayFormatter.string(from: date), monthFormatter.string(from: date).uppercased())
    }
}

#Preview {
    HolidayRowView(holiday: PublicHoliday(date: "", localName: "", name: "", countryCode: "", fixed: true, global: true, counties: [""], launchYear: 2018, types: ["public"]))
}
