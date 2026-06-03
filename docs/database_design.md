# Database Design Overview

## Philosophy

The database design focuses on:

* flexibility
* clear relationships
* avoiding duplicated data
* future scalability

Linking tables are used heavily to represent relationships.

---

# Core Tables

## Users

```text
users
- id
- name
- email
- password_hash
- role
- last_dive_date
- dive_count
- approved_status
```

Stores member account information.

---

## Certifications

```text
certifications
- id
- user_id
- agency
- certification_level
- google_drive_file_id
- verified_status
```

Stores diver certification information.

Certification files themselves are stored in Google Drive.

---

## Events

```text
events
- id
- title
- description
- event_type
- organiser_id
- location
- start_time
- end_time
- capacity
- approval_required
```

Represents:

* dives
* meetings
* socials
* committee activities

---

## Registrations

```text
registrations
- id
- user_id
- event_id
- status
- payment_status
- organiser_notes
```

Links users to events.

This avoids storing:

* members directly inside events
* events directly inside members

---

## Assets

```text
assets
- id
- name
- asset_type
- status
- default_cost
```

Represents:

* boat
* ute
* tanks
* regulators
* BCDs
* weights
* safety equipment

---

## Asset Bookings

```text
asset_bookings
- id
- asset_id
- registration_id
- start_time
- end_time
- booking_status
```

Tracks which assets are booked for which registrations.

---

## Payments

```text
payments
- id
- user_id
- registration_id
- amount
- payment_status
- stripe_session_id
```

Tracks payment information and Stripe references.

---

## Access Logs

```text
access_logs
- id
- user_id
- login_time
- logout_time
- ip_address
```

Tracks user access activity.

---

# Planned Relationships

```text
User
  has many Registrations

Event
  has many Registrations

Registration
  belongs to User
  belongs to Event

Asset
  has many AssetBookings

Registration
  has many AssetBookings
```

---

# Future Considerations

Potential future additions:

* incident reports
* maintenance logs
* dive logs
* waitlists
* notification history
* buddy pairing
* inventory tracking
