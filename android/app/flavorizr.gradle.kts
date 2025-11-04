import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "dev.flutter.template"
            resValue(type = "string", name = "app_name", value = "[Dev] Flutter template")
        }
        create("stag") {
            dimension = "flavor-type"
            applicationId = "stag.flutter.template"
            resValue(type = "string", name = "app_name", value = "[Stag] Flutter template")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.flutter.template"
            resValue(type = "string", name = "app_name", value = "Flutter template")
        }
    }
}