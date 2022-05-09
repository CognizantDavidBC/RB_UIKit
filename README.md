# UIKit Assignment

![Screenshot simulator](https://user-images.githubusercontent.com/88148565/167357820-c1c1a386-f0b9-4dc7-89b7-42d20b6f8b2e.png)

## Architecture: **MVVM**
- Model: `User`
- View: `UITableView` & `UIViewController`
- ViewModel: Stores the list of users

## CSV Decode Method:
- `protocol CsvParser` is designed for reutilization in the future for different models
- The common methods for different models are included using a protocol extension of `CsvParser`
- `UserCsvParser` handles the individual characteristics of a `User`
- The parse process is done in the background, the VC is updated once finished

## App Life Cycle:
At launch, the CSV parse will start in the background, once finish the VC will reload the tableView and display the data. While the csv file is being decoded, the table view will display a `UIActivityIndicatorView`. If there is any type of error, an alert will be displayed explaining the problem.

## UI
The app includes a single view (`UITableView`). The table view uses custom cell created in a separed `xib`.

## Testing
The project includes Unit Tests to test the `Model` and the `CsvParser`.

## Notes
App performace tested using a list of 10K users. To test this scenario, switch comments between lines `11` & `12` at `Utilities/CsvParser/UserCsvParser`
