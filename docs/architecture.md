# Architecture Overview

## Application Structure

The project follows an MVC-style architecture.

### Models

Models represent the application's data and database relationships.

Examples:

* User
* Event
* Registration
* Asset
* Certification

### Controllers

Controllers receive requests, process application logic, and render responses.

Examples:

* EventsController
* RegistrationsController
* AssetsController

### Views

Views are HTML templates rendered by Rails using ERB templates.

Frontend interactivity is handled with JavaScript where required.

---

# Planned Folder Structure

```text
app/
  controllers/
  models/
  views/
  services/
  javascript/
  assets/

docs/
```

---

# Controllers

Controllers are separated by feature area.

Examples:

```text
sessions_controller.rb
events_controller.rb
registrations_controller.rb
assets_controller.rb
admin_controller.rb
```

This keeps responsibilities separated and avoids extremely large controller files.

---

# Models

Models represent database-backed objects.

Examples:

```text
user.rb
event.rb
registration.rb
asset.rb
asset_booking.rb
```

Relationships between models will be managed using Rails associations.

---

# Services

Services are used where logic spans multiple models or systems.

Initial planned services:

```text
booking_service.rb
payment_service.rb
google_drive_service.rb
email_service.rb
```

## Why Services Are Used

### Booking Service

Handles:

* pending registrations
* capacity checking
* booking expiry timers
* organiser approvals

### Payment Service

Handles:

* Stripe integration
* payment confirmation
* payment status updates

### Google Drive Service

Handles:

* certification uploads
* file retrieval
* Drive integration

### Email Service

Handles:

* registration confirmations
* organiser notifications
* reminders
* password reset emails

---

# Frontend Philosophy

The application is planned as a server-rendered web application.

Rails will render the majority of pages.

JavaScript will be used for:

* table filtering
* countdown timers
* live price updates
* booking interactivity

The project is intentionally avoiding a heavy frontend framework such as React.

---

# Authentication

The system will support:

* member accounts
* organiser accounts
* admin accounts

Admin accounts are planned to use:

* Google Authenticator TOTP 2FA

---

# Storage Strategy

The database will store:

* metadata
* references
* relationships

Large uploaded files such as certifications will be stored externally using Google Drive.

The database will only store the Google Drive file ID or reference.

---

# Event Philosophy

All activities are treated as events.

Examples:

* dive trips
* social events
* AGM/SGM
* committee meetings

Some events may have additional meeting-related data.

---

# Organiser Approval Philosophy

Events may use:

* open registration
  OR
* organiser approval required

The goal is to provide organisers flexibility without turning the club into a formal competency-certification body.

Participants remain responsible for:

* honestly representing qualifications
* diving within their training and comfort level
* ensuring they are medically fit to dive
