const mongoose = require('mongoose');

const studentSchema = new mongoose.Schema({
    firstName: { type: String, required: true },
    lastName: { type: String, required: true },
    course: { type: String, required: true },
    year: { type: String, required: true },
    enrolled: { type: Boolean, required: true }
});

module.exports = mongoose.model('Student', studentSchema);
